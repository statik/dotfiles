# dotfiles

 * install zprezto
 * install homebrew
 * brew install stow

## vim

 * install pathogen
 * install vim-colors-solarized
    ```bash
    $ cd ~/.vim/bundle
    $ git clone git://github.com/altercation/vim-colors-solarized.git
    $ git clone https://github.com/tpope/vim-sensible.git
    $ git clone https://github.com/fatih/vim-go.git
    $ git clone https://github.com/leafgarland/typescript-vim.git
    $ git clone https://github.com/ElmCast/elm-vim.git
    ```

## syncing

These dotfiles will automatically get installed into codespaces. To manually install:

* install zprezto
* install homebrew
* `brew install stow`
* `./install.sh`

## Optional: fully enabled ffmpeg

* brew uninstall --force --ignore-dependencies ffmpeg
* brew install --ignore-dependencies chromaprint
* brew install amiaopensource/amiaos/decklinksdk
* brew cask install xquartz
* options=$(brew options homebrew-ffmpeg/ffmpeg/ffmpeg | grep -vE '\s' | grep -- '--with-' | grep -vi game-music-emu | tr '\n' ' ')
* brew install homebrew-ffmpeg/ffmpeg/ffmpeg ${options}


## TODO

Set up powershell profiles, and Brewfile.
