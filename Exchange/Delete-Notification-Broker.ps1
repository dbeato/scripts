﻿forfiles /p "C:\Program Files\Microsoft\Exchange Server\V15\Logging\NotificationBroker" /s /m *.* /c "cmd /c Del @path" /d -15