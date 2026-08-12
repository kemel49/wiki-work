local p = {}

function p.main(frame)
    local args = frame:getParent().args
    -- Every argument from template
    local id = args["id"] or args[1]
    local title = args["title"]
    local plainUrl = args["plainurl"] or args["plainlink"]
    local page = args["page"]
    local pg = args["pg"]
    local text = args["text"]
    local keywords = args["keywords"]

    -- Check if ID is populated or not
    if id == "" or id == nil then
        return "<span class=error>Please specify an ID for Google Book</span>"
    end
    -- Check if ID is 12 character long or not
    if #id ~= 12 then
        return "<span class=error>Please enter a valid Google Books ID</span>"
    end

    -- URL Prefix and suffix
    local urlPrefix = "https://books.google.com/books?id="
    local urlSuffix

    -- Optional URL suffixes after id
    -- page and pg both produces different output
    if page ~= "" or page ~= nil then
        urlSuffix = "&pg=PA"..page
    else
        urlSuffix = nil
    end

    if pg ~= "" or pg ~= nil then
        urlSuffix = "&pg="..pg
    else
        urlSuffix = nil

    -- URL and text wrapped together
    local wrapperText
    if title == "" or title == nil then
        wrapperText = mw.title.getCurrentTitle().text..'] at [[Google Books]]'
    else
        wrapperText = title..'] at [[Google Books]]'
    end
    -- Final output
    -- If Needed only Plain URL
    if plainUrl == "yes" or plainUrl == "y" then
        return urlPrefix..id
    end
    -- Wrapped URL with texts
    return '['..urlPrefix..id..urlSuffix..' '..wrapperText

end
return p
