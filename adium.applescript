script ResultXml
	to create()
		script ResultXmlInstance
			property parent : ResultXml
			property bodyText : ""
		end script
	end create
	
	on append(uid, arg, title, subtitle)
		set my bodyText to my bodyText & "
	<item uid='" & uid & "' arg='" & arg & "' valid='yes'>
		<title>" & title & "</title>
		<subtitle>" & subtitle & "</subtitle>
	</item>"
	end append
	
	on output()
		return "<?xml version='1.0'?><items>" & my bodyText & "
</items>"
	end output
end script

on getContacts(theQuery)
	set theXml to ResultXml's create()
	
	if length of theQuery > 2 then
		tell application "Adium"
			repeat with theContact in (every contact whose status type is not offline and display name starts with theQuery)
				set {theId, theTitle, theSubtitle} to {id, display name, name} of theContact
				tell theXml to append(theId, theId, theTitle, theSubtitle)
			end repeat
		end tell
	end if
	
	return theXml's output()
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
	set theXml to ResultXml's create()
	
	tell application "Adium"
		repeat with theStatus in every status
			set {theTitle, theMessage, theId} to {title, status message, id} of theStatus
			if (theQuery is "") or (theTitle starts with theQuery) then
				tell theXml to append(theId, theId, theTitle, theMessage)
			end if
		end repeat
	end tell
	
	return theXml's output()
end getStatuses

on setStatus(theQuery)
	tell application "Adium"
		set status of every account whose status type is not offline to the first status whose id is theQuery
	end tell
end setStatus