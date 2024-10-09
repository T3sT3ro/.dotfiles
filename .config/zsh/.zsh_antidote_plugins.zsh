fpath+=( $HOME/.cache/antidote/zsh-users/zsh-completions/src )
fpath+=( $HOME/.cache/antidote/mattmc3/ez-compinit )
source $HOME/.cache/antidote/mattmc3/ez-compinit/ez-compinit.plugin.zsh
fpath+=( $HOME/.cache/antidote/peterhurford/up.zsh )
source $HOME/.cache/antidote/peterhurford/up.zsh/up.plugin.zsh
fpath+=( $HOME/.cache/antidote/mattmc3/zman )
source $HOME/.cache/antidote/mattmc3/zman/zman.plugin.zsh
fpath+=( $HOME/.cache/antidote/z-shell/zsh-zoxide )
source $HOME/.cache/antidote/z-shell/zsh-zoxide/zsh-zoxide.plugin.zsh
source $ZDOTDIR/.aliases
export PATH="$HOME/.cache/antidote/romkatv/zsh-bench:$PATH"
fpath+=( $HOME/.cache/antidote/getantidote/use-omz )
source $HOME/.cache/antidote/getantidote/use-omz/use-omz.plugin.zsh
source $HOME/.cache/antidote/ohmyzsh/ohmyzsh/lib/clipboard.zsh
source $HOME/.cache/antidote/ohmyzsh/ohmyzsh/lib/theme-and-appearance.zsh
fpath+=( $HOME/.cache/antidote/ohmyzsh/ohmyzsh/plugins/colored-man-pages )
source $HOME/.cache/antidote/ohmyzsh/ohmyzsh/plugins/colored-man-pages/colored-man-pages.plugin.zsh
fpath+=( $HOME/.cache/antidote/ohmyzsh/ohmyzsh/plugins/command-not-found )
source $HOME/.cache/antidote/ohmyzsh/ohmyzsh/plugins/command-not-found/command-not-found.plugin.zsh
fpath+=( $HOME/.cache/antidote/ohmyzsh/ohmyzsh/plugins/copybuffer )
source $HOME/.cache/antidote/ohmyzsh/ohmyzsh/plugins/copybuffer/copybuffer.plugin.zsh
fpath+=( $HOME/.cache/antidote/ohmyzsh/ohmyzsh/plugins/copyfile )
source $HOME/.cache/antidote/ohmyzsh/ohmyzsh/plugins/copyfile/copyfile.plugin.zsh
fpath+=( $HOME/.cache/antidote/ohmyzsh/ohmyzsh/plugins/copypath )
source $HOME/.cache/antidote/ohmyzsh/ohmyzsh/plugins/copypath/copypath.plugin.zsh
fpath+=( $HOME/.cache/antidote/ohmyzsh/ohmyzsh/plugins/extract )
source $HOME/.cache/antidote/ohmyzsh/ohmyzsh/plugins/extract/extract.plugin.zsh
fpath+=( $HOME/.cache/antidote/ohmyzsh/ohmyzsh/plugins/magic-enter )
source $HOME/.cache/antidote/ohmyzsh/ohmyzsh/plugins/magic-enter/magic-enter.plugin.zsh
fpath+=( $HOME/.cache/antidote/ohmyzsh/ohmyzsh/plugins/fancy-ctrl-z )
source $HOME/.cache/antidote/ohmyzsh/ohmyzsh/plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh
fpath+=( $HOME/.cache/antidote/belak/zsh-utils/history )
source $HOME/.cache/antidote/belak/zsh-utils/history/history.plugin.zsh
fpath+=( $HOME/.cache/antidote/belak/zsh-utils/utility )
source $HOME/.cache/antidote/belak/zsh-utils/utility/utility.plugin.zsh
if ! (( $+functions[zsh-defer] )); then
  fpath+=( $HOME/.cache/antidote/romkatv/zsh-defer )
  source $HOME/.cache/antidote/romkatv/zsh-defer/zsh-defer.plugin.zsh
fi
fpath+=( $HOME/.cache/antidote/zdharma-continuum/fast-syntax-highlighting )
zsh-defer source $HOME/.cache/antidote/zdharma-continuum/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fpath+=( $HOME/.cache/antidote/zsh-users/zsh-autosuggestions )
source $HOME/.cache/antidote/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fpath+=( $HOME/.cache/antidote/zsh-users/zsh-history-substring-search )
source $HOME/.cache/antidote/zsh-users/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
