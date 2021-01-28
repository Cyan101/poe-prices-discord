## PoE-Prices-Discord
Searches Path of Exiles official trade website for certain items prices every 10ish min

![PoE-Prices-Discord](https://raw.githubusercontent.com/Cyan101/poe-prices-discord/main/example.png)

## How to Use

1. Setup a discord bot on the official dev portal
2. Create a settings.yaml based off the example below, using your discord ID (Available in dev mode), and other optionals
3. Invite the bot to the server with the url output in terminal on launch
4. Use your prefix + command to run things, such as `!start`

### settings.yaml

```
---
token: 'xxx'
prefix: '!'
owner: 12345678910
emoji: true
sess_id: '123456789abcdefgh'
```
* Token needs to be your discord bot token (from dev panel)
* Prefix is what you use to tell the bot you are using a command in discord (eg. !start or ~start)
* Owner needs to be your discord id (can be grabbed in discord dev mode) to stop others controlling admin commands
* Emoji is optional true/false, if true you need to upload the emoji in the emoji folder to your server
* Sess_id is your POESESSID, you can see this from a network request on the main/trade site or maybe your cookies, it "SHOULD" use your blacklist to help ignore price fixers/not sellers

## To-Do
* Add user-agent (Not really required)
* Have option of sleep instead of just cancelling the loop
