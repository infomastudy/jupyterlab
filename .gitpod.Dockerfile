FROM gitpod/workspace-full

RUN sudo apt update | tee -a /tmp/apt.log \
 && sudo apt install -y \
     zsh | tee -a /tmp/apt.log \
 && sudo rm -rf /var/lib/apt/lists/*

RUN cd $HOME \
 && wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh | tee /tmp/wget-oh-my-zsh.log

RUN sed -i 's/_THEME=\"robbyrussell\"/_THEME=\"xiong-chiamiov-plus\"/g' ~/.zshrc

# RUN sed -i 's/plugins=(git)/plugins=(git gradle gradle-completion adb sdk common-aliases dircycle dirhistory dirpersist history copydir copyfile autojump fd git-completion git-auto-status git-prompt gitignore git-lfs git-extras last-working-dir per-directory-history perms wd safe-paste thefuck systemadmin scd pj magic-enter man command-not-found jump timer colored-man-pages jsontools colorize ripgrep httpie sprunge nmap transfer universalarchive catimg extract)/g' ~/.zshrc

RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0 | tee /tmp/apt.log \
 && sudo apt-add-repository https://cli.github.com/packages -y | tee -a /tmp/apt.log \
 && sudo apt update | tee -a /tmp/apt.log \
 && sudo apt install -y \
     gh | tee -a /tmp/apt.log \
 && sudo rm -rf /var/lib/apt/lists/*

 RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

RUN sudo apt update | tee -a /tmp/apt.log \
 && sudo apt install -y \
     git-lfs | tee -a /tmp/apt.log \
 && sudo rm -rf /var/lib/apt/lists/*

ENV GIT_INTERNAL_GETTEXT_TEST_FALLBACKS=1

RUN pyenv install anaconda3-2020.11 \
 && pyenv global anaconda3-2020.11

RUN bash -c "conda init bash"

RUN zsh -c "conda init zsh"

RUN conda update -y --all

RUN jupyter-lab --generate-config

RUN sed -i "s/# c.ServerApp.ip = 'localhost'/c.ServerApp.ip = '0.0.0.0'/g" /home/gitpod/.jupyter/jupyter_lab_config.py

# RUN conda config --add channels conda-forge
# RUN conda config --add channels pytorch
# RUN conda config --add channels intel

# RUN conda config --set channel_priority strict