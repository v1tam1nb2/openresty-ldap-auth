FROM ubuntu:20.04

ARG GO_VERSION="1.20.2"

ENV DEBIAN_FRONTEND="noninteractive"

# 最低限のコマンドインストール
# golangのセットアップ
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y wget curl vim openssl git zip jq gettext-base && \
    # クリーニング
    rm -rf /root/.cache && rm -rf /tmp/*\
    apt-get autoremove && apt-get autoclean && apt-get clean && rm -fr /var/lib/apt/lists/*

# golang install
RUN wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -xzf go${GO_VERSION}.linux-amd64.tar.gz -C /usr/local/ && \
    echo 'export PATH=$PATH:/usr/local/go/bin' >> /root/.profile && \
    rm go${GO_VERSION}.linux-amd64.tar.gz && \
    rm -rf /root/.cache && rm -rf /tmp/*

# nginx auth mod build
RUN cd /usr/local && \
    git clone https://github.com/iij/ngx_auth_mod.git -b master --depth 1 && \
    . /root/.profile && \
    cd ngx_auth_mod && ./build.sh && \
    mv bin/* /usr/local/bin/
    
COPY ./src/ngx_auth_mod/auth-ldap.conf /ngx_auth_mod/auth-ldap.conf

ENV DEBIAN_FRONTEND=""

# コンテナ起動時の実行コマンド設定
ENTRYPOINT [ "/usr/local/bin/ngx_ldap_auth","/ngx_auth_mod/auth-ldap.conf"]