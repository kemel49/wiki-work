local p = {}

function p.main(frame)
    local args = frame:getParent().args
    -- Google Book id and Title and Plain URL value
    local id = args["id"] or args[1]
    local title = args["title"]
    local plainUrl = args["plainlink"]

    -- Check if ID is populated or not
    if id == "" or id == nil then
        return "<span class=error>Please specify an ID for Google Book</span>"
    end
    -- Check if ID is 12 character long or not
    if #id ~= 12 then
        return "<span class=error>Please enter a valid Google Books ID</span>"
    end

    -- URL Prefix
    local urlPrefix = "https://books.google.com/books?id="
    -- If Needed only Plain URL
    if plainUrl == "yes" then
        return urlPrefix..id
    end

    -- URL and text wrapped together
    local wrapperText
    if title == "" or title == nil then
        wrapperText = mw.title.getCurrentTitle().text..'] at [[Google Books]]'
    else
        wrapperText = title..'] at [[Google Books]]'
    end
    -- Final output
    return '['..urlPrefix..id..' '..wrapperText

end
return p
