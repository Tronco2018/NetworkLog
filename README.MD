# NetworkLog
### The fast and (kinda of) reliable network logger
Tired of having separate consoles and logfiles from different machines across the network?
NetworkLog can help you! It's a simple http program that reads requests and turns them into logs.

## Request specifications
To get a log going implement an http requests sender at port 7564, the webserver accepts a json body that has to be formatted the following way:
{
  "program":"exampleProgramName",
  "message":"exampleMessageBody",
  "level":"INFO/WARNING/ERROR"
}
