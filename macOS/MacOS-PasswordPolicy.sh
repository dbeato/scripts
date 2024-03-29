#!/bin/bash
##########################################################################################################
## Purpose:  Create a pwpolicy XML file based upon variables and options included below.
##          Policy is applied and then file gets deleted. Use "sudo pwpolicy -u <user> -getaccountpolicies"
##          to see it, and "sudo pwpolicy -u <user> -clearaccountpolicies" to clear it.
## 
## Usage:   Edit variables in Variable flowerbox below.
##          Then run as a policy from Casper, or standalone as root.
##
## Tested on: OS X 10.10 and 10.11
##
#########################################################################################################

# get logged-in user and assign it to a variable
LOGGEDINUSER=$(ls -l /dev/console | awk '{print $3}')

echo "LOGGEDINUSER is: $LOGGEDINUSER"

##############################################################################
# Variables for script and commands generated below.
#
# EDIT AS NECESSARY FOR YOUR OWN PASSWORD POLICY
# AND COMPANY INFORMATION
#
COMPANY_NAME="1kosmos"  # CHANGE THIS TO YOUR COMPANY NAME
LOCKOUT=300                     # 5min lockout
MAX_FAILED=5                   # 5 max failed logins before locking
PW_EXPIRE=90                    # 90 days password expiration
MIN_LENGTH=8                    # at least 8 chars for password
MIN_NUMERIC=1                   # at least 1 number in password
MIN_ALPHA_LOWER=1               # at least 1 lower case letter in password
MIN_UPPER_ALPHA=1               # at least 1 upper case letter in password
MIN_SPECIAL_CHAR=1              # at least one special character in password
PW_HISTORY=5                   # remember last 10 passwords

exemptAccount1="administrator"          #Exempt account used for remote management. CHANGE THIS TO YOUR EXEMPT ACCOUNT
#
##############################################################################

#################################################
##### create pwpolicy.plist in /private/var/tmp
# Password policy using variables above is:
# Change as necessary in variable flowerbox above
# --------------------------------------------------
# pw's must be at least 8 chars
# pw's must have at least 1 lower case letter
# pw's must have at least 1 upper case letter
# pw's must have at least 1 special non-alpha/non-numeric character
# pw's must have at least 1 number
# can't use any of the previous 10 passwords
# pw's expire at 90 days
# 10 failed successive login attempts results in a 300sec lockout, then auto enables

echo "<dict>
 <key>policyCategoryAuthentication</key>
  <array>
   <dict>
    <key>policyContent</key>
     <string>(policyAttributeFailedAuthentications < policyAttributeMaximumFailedAuthentications) OR (policyAttributeCurrentTime > (policyAttributeLastFailedAuthenticationTime + autoEnableInSeconds))</string>
    <key>policyIdentifier</key>
     <string>Authentication Lockout</string>
    <key>policyParameters</key>
  <dict>
  <key>autoEnableInSeconds</key>
   <integer>$LOCKOUT</integer>
   <key>policyAttributeMaximumFailedAuthentications</key>
   <integer>$MAX_FAILED</integer>
  </dict>
 </dict>
 </array>


 <key>policyCategoryPasswordChange</key>
  <array>
   <dict>
    <key>policyContent</key>
     <string>policyAttributeCurrentTime > policyAttributeLastPasswordChangeTime + (policyAttributeExpiresEveryNDays * 24 * 60 * 60)</string>
    <key>policyIdentifier</key>
     <string>Change every $PW_EXPIRE days</string>
    <key>policyParameters</key>
    <dict>
     <key>policyAttributeExpiresEveryNDays</key>
      <integer>$PW_EXPIRE</integer>
    </dict>
   </dict>
  </array>


  <key>policyCategoryPasswordContent</key>
 <array>
  <dict>
   <key>policyContent</key>
    <string>policyAttributePassword matches '.{$MIN_LENGTH,}+'</string>
   <key>policyIdentifier</key>
    <string>Has at least $MIN_LENGTH characters</string>
   <key>policyParameters</key>
   <dict>
    <key>minimumLength</key>
     <integer>$MIN_LENGTH</integer>
   </dict>
  </dict>


  <dict>
   <key>policyContent</key>
    <string>policyAttributePassword matches '(.*[0-9].*){$MIN_NUMERIC,}+'</string>
   <key>policyIdentifier</key>
    <string>Has a number</string>
   <key>policyParameters</key>
   <dict>
   <key>minimumNumericCharacters</key>
    <integer>$MIN_NUMERIC</integer>
   </dict>
  </dict>


  <dict>
   <key>policyContent</key>
    <string>policyAttributePassword matches '(.*[a-z].*){$MIN_ALPHA_LOWER,}+'</string>
   <key>policyIdentifier</key>
    <string>Has a lower case letter</string>
   <key>policyParameters</key>
   <dict>
   <key>minimumAlphaCharactersLowerCase</key>
    <integer>$MIN_ALPHA_LOWER</integer>
   </dict>
  </dict>


  <dict>
   <key>policyContent</key>
    <string>policyAttributePassword matches '(.*[A-Z].*){$MIN_UPPER_ALPHA,}+'</string>
   <key>policyIdentifier</key>
    <string>Has an upper case letter</string>
   <key>policyParameters</key>
   <dict>
   <key>minimumAlphaCharacters</key>
    <integer>$MIN_UPPER_ALPHA</integer>
   </dict>
  </dict>


  <dict>
   <key>policyContent</key>
    <string>policyAttributePassword matches '(.*[^a-zA-Z0-9].*){$MIN_SPECIAL_CHAR,}+'</string>
   <key>policyIdentifier</key>
    <string>Has a special character</string>
   <key>policyParameters</key>
   <dict>
   <key>minimumSymbols</key>
    <integer>$MIN_SPECIAL_CHAR</integer>
   </dict>
  </dict>


  <dict>
   <key>policyContent</key>
    <string>none policyAttributePasswordHashes in policyAttributePasswordHistory</string>
   <key>policyIdentifier</key>
    <string>Does not match any of last $PW_HISTORY passwords</string>
   <key>policyParameters</key>
   <dict>
    <key>policyAttributePasswordHistoryDepth</key>
     <integer>$PW_HISTORY</integer>
   </dict>
  </dict>

 </array>
</dict>" > ~/pwpolicy.plist
##### end of pwpolicy.plist generation script
###################################################

#Check for non-admin account before deploying policy
if [ "$LOGGEDINUSER" != "$exemptAccount1" ]; then
  chown $LOGGEDINUSER:staff ~/pwpolicy.plist
  chmod 644 ~/pwpolicy.plist

  # clear account policy before loading a new one
  pwpolicy -u $LOGGEDINUSER -clearaccountpolicies 
  pwpolicy -u $LOGGEDINUSER -setaccountpolicies ~/pwpolicy.plist

elif [ "$LOGGEDINUSER" == "$exemptAccount1" ]; then
    echo "Currently $exemptAccount1 is logged in and the password policy was NOT set. This script can only be run if the standard computer user is logged in."
    rm -f ~/pwpolicy.plist
    exit 1
fi

#delete staged pwploicy.plist
rm -f ~/pwpolicy.plist

echo "Password policy successfully applied. Run \"sudo pwpolicy -u <user> -getaccountpolicies\" to see it."
exit 0