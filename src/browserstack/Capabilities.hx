package browserstack;

typedef Capabilities = {
  browserName:BrowserName,
  ?browser_version: String,
  browserstack: {
    user:String,
    key:String,
    local:Bool,
  },
  ?os: String,
  ?os_version: String,
  ?resolution: String,
  ?platform: String,
  ?device: String,
  ?version: String
}
