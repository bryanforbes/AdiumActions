on outputXML(theItems)
	set outputText to "<?xml version='1.0'?><items>"
	repeat with theItem in every record of theItems
		set outputText to outputText & "
	<item uid='" & (uid of theItem) & "' arg='" & (arg of theItem) & "' valid='yes'>
		<title>" & (theTitle of theItem) & "</title>
		<subtitle>" & (subtitle of theItem) & "</subtitle>
	</item>"
	end repeat
	set outputText to outputText & "
</items>"
	
	return outputText
end outputXML

on getContacts(theQuery)
	set theContacts to {}
	
	if length of theQuery > 2 then
		tell application "Adium"
			repeat with theContact in (every contact whose status type is not offline and display name starts with theQuery)
				set {theId, theTitle, theSubtitle} to {id, display name, name} of theContact
				
				copy {uid:theId, arg:theId, theTitle:theTitle, subtitle:theSubtitle} to the end of theContacts
			end repeat
		end tell
	end if
	
	return outputXML(theContacts)
end getContacts

on startChat(theQuery)
	tell application "Adium"
		set theUser to first contact whose (id is theQuery)
		
		if not (exists (chats whose id is theQuery)) then
			if not (exists first chat window) then
				tell account of theUser to make new chat with contacts {theUser} with new chat window
			else
				set theWindow to first chat window
				tell account of theUser to make new chat with contacts {theUser} in window theWindow
			end if
		end if
		
		tell (first chat whose id is theQuery) to become active
		activate
	end tell
end startChat

on getStatuses(theQuery)
	set theStatuses to {}
	
	tell application "Adium"
		repeat with theStatus in every status
			set {theTitle, theMessage, theId} to {title, status message, id} of theStatus
			if (theQuery is "") or (theTitle starts with theQuery) then
				copy {uid:theId, arg:theId, theTitle:theTitle, subtitle:theMessage} to the end of theStatuses
			end if
		end repeat
	end tell
	
	return outputXML(theStatuses)
end getStatuses

on setStatus(theQuery)
	tell application "Adium"
		set status of every account whose status type is not offline to the first status whose id is theQuery
	end tell
end setStatus