# Status Spotify

Script que mostra a música que está tocando no Spotify

## Instalação

1. Clone este repositório:

```bash
git clone https://github.com/vanildosouto/tmux-spotify
```

2. Adicione o caminho completo do script no seu `~/.tmux.conf`
Exemplo:

```conf
set -g status-right ' #([caminho completo]/status-spotify.sh) #[fg=colour233,bg=colour241,bold] %d/%m %a #[fg=colour233,bg=colour245,bold] %H:%M '
```

**Testado somente no Linux**
