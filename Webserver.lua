local socket = require("socket")
local json = require("dkjson")

Webserver = {}

function Webserver:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Webserver:start()
    local server = assert(socket.bind("*", 7564))
    print("Server in ascolto su porta 7564...")
    local logger = Logger:new()

    while true do
        local client = server:accept()
        client:settimeout(1)

        local request = ""
        while true do
            local line, err = client:receive()
            if not line or line == "" then break end
            request = request .. line .. "\n"
        end

        local contentLength = request:lower():match("content%-length: (%d+)")
        local body = ""
        if contentLength then
            body = client:receive(tonumber(contentLength))
        end

       
        local data, pos, err = json.decode(body, 1, nil)
        if err then
            print("Errore parsing JSON:", err)
        else
            local hostname = client:getpeername()
            local program = data.program or "N/A"
            local level = data.level or "N/A"
            local message = data.message or "N/A"
            logger:log(message, level, program, hostname)
        end

        local response = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nReceived"
        client:send(response)
        client:close()
    end
end
