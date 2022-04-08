FROM gitea/gitea:1.16.5
COPY init-data-directory.tar.gz /tmp/init-data-directory.tar.gz
COPY modified-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]