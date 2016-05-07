# Setup Instructions:

## Installing GHC:

Although the [Haskell Platform](https://www.haskell.org/platform/) is the most
straightforward way to get a Haskell environment set up, it bundles up a lot
of extras we won't be needing during this presentation, and as such I recommend
installing just the Glasgow Haskell Compiler distribution alone.

### Windows:

Bundled with the standard [Haskell Platform](https://www.haskell.org/platform/).

### Linux:

Debian-based: `sudo apt-get install ghc`

RHEL-based: `sudo yum install ghc`

Arch-based: `sudo pacman -S ghc`

### OSX:

Brew: `brew install ghc`

MacPorts: `sudo port install ghc`

### Final steps for GHCi:

On both Linux and OSX, the installation methods presented above should have all
placed `ghc` and `ghci` somewhere in your PATH.

On Windows you can start `ghci` by issuing a `Run... WinGHCi` directly.
For compiling with `ghc`, please add the appropriate 'bin' directory located in
the Haskell Platform's installation directory (`C:\GHC\` by default) to you path.


## Running the examples.

There are three simple ways to run/test your code:

The boring one involves using `ghc` to compile your code into a binary and then
running it as so:

```sh
ghc -o app.exe app.hs applib.hs
./app.exe arg1 arg2 ...
```

A quick and easy way around running two commands is to just use `runhaskell`,
which is a simple script that sets stuff up and then calls `runghc` as so:

```sh
# NOTE: you only call it on the file which defines `main`
runhaskell app.hs arg1 arg2 ...
```

And lastly, if you want to load the files and play around with them in `ghci`,
you can invoke it as such:

```sh
ghci app.hs applib.hs
```
