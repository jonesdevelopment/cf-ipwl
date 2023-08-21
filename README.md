<div align="center">
  <!-- Introduction -->
  <p>
    <h1>cloudflare IP whitelister</h1>
    Simple shell script for Linux that prevents non-Cloudflare IPs from reaching your backend.
    <br>
    Blocks unknown hosts from accessing your backend's HTTP and HTTPS ports using IPTables
  </p>
  
  <!-- Badges & icons -->
  [![](https://img.shields.io/github/issues/jonesdevelopment/cf-ipwl)](https://github.com/jonesdevelopment/cf-ipwl/issues)
  [![](https://img.shields.io/discord/923308209769426994.svg?logo=discord)](https://jonesdev.xyz/discord)
  [![](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
  <br>
  <br>
  <!-- Quick navigation -->
  [Issues](https://github.com/jonesdevelopment/cf-ipwl/issues)
  |
  [Pull Requests](https://github.com/jonesdevelopment/cf-ipwl/pulls)
  |
  [Discord](https://jonesdev.xyz/discord)
  |
  [License](https://github.com/jonesdevelopment/cf-ipwl/blob/main/README.md#license)
</div>

## How to use

1. Run the script with super user privileges (`sudo ./cloudflare.sh`)
2. The rules are automatically applied or removed, depending if you the rules already existed
    - (If you want to undo the changes, run the script again)

If you encounter any issues or bugs, please open a [GitHub issue](https://github.com/jonesdevelopment/cf-ipwl/issues).

## Expected outcome

Running the script for the first time (Adding rules)
```
user@webserver:~# sudo ./cloudflare.sh 
Downloading latest IP ranges from the official Cloudflare website...
Allowing X.X.X.X/X (cloudflare IP)...
[...]
Adding rule that disallows all connections from untrusted hosts...
Done!
user@webserver:~# 
```

Running the script for the second first time (Removing existing rules)
```
user@webserver:~# sudo ./cloudflare.sh 
Downloading latest IP ranges from the official Cloudflare website...
Removing X.X.X.X/X (duplicate entry)...
[...]
Removing rule that disallows all connections from untrusted hosts...
Done!
user@webserver:~# 
```

## License

cf-ipwl is licensed under the [GNU General Public License 3.0](https://www.gnu.org/licenses/gpl-3.0.en.html).
