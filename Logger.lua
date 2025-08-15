Logger = {}

function Logger:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Logger:log(message, level, programName, hostname)
    level = level or "INFO"
    programName = programName or "Unknown"
    local timestamp = os.date("%Y%m%d-%H:%M")
    local logMessage = "{"..hostname.."}"..timestamp.."<"..level..">["..programName.."]:"..message
    Logger:writeToFile(logMessage.."\n")
    print(logMessage)
end

function Logger:writeToFile(message)
    local file = assert(io.open("logfile.log", "a"),"Failed to open logfile")
    file:write(message)
    file:close()
end

    