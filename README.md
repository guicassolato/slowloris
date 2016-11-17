# slowloris
This is a Ruby implementation of a Slowloris DoS Attack test tool, based on Dr Mike Pound (University of Nottingham)'s great explanation available at https://youtu.be/XiFkyR35v2Y.

For further information on the Slowloris DoS Attack, please see [Slowloris](https://en.wikipedia.org/wiki/Slowloris_(computer_security)).

## Usage
```
ruby slowloris.rb <target> <n>
```

where ``<target>`` is the URL of a web page whose host you want to test against Slowloris DoS attacks and ``<n>`` is the number of sockets.

## Caution!
Although many web servers nowadays have implemented some proper security measures to protect themselves against Slowloris attacks, this script can still make some severe damage to old or misconfigured web servers. **Use it wisely and at your own responsibility!**

Neither myself nor Dr Mike Pound who has contribute indirectly to this implementation will take any responsibility for damages caused using this script or any other variation based on it.

## License
As long as you always make sure to highlight the risks envolved, feel free to clone it, improve it and share it independently as you wish. You are totaly welcome to contribute by creating a pull request as well.

Furthrmore, the code is licensed under the MIT License.

## Support
No support will be provided. Use it at your own risk. But if you need to get in touch for any other reason or you have significant improvement advices to share, please open an issue and I promise I'll try to respond it as soon as possible.