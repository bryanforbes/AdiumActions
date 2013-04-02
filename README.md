# AdiumActions

This is the repository for my Adium workflow for Alfred 2. To install the extension, issue the following command:

$ make install

This will compile the AppleScript, zip up the appropriate files, and open the extension in Alfred 2.

# Actions

## status {name}

Typing `status ` into Alfred 2 will bring up a list of statuses to set all online accounts to. This list can be
further filtered by the starting characters of the status name.

## chat {display name}

Typing `chat ` into Alfred 2 followed by at least 3 characters of a contact's display name will bring up a list
of contacts who match. The contact's account-specific username will be displayed below their display name to
distinguish between contacts who may have multiple accounts on different services.
