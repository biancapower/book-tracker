# Book Tracker

## Development

### Running the debugger

The `debug` gem is used to run the debugger. Because Foreman is used in this project, remote debugging has been configured.
To run the debugger:

- Leave the server running
- Add a breakpoint to the code (`debugger`)
- Open a new terminal
- Run the following command:

```sh
rails dev:debug
```
