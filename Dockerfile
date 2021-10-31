FROM  tensorflow/tensorflow:latest-gpu-jupyter

WORKDIR /tmp

# kite engine for enhanced autocomplete
COPY --chmod=770 kite-installer.sh ./
RUN ./kite-installer.sh

RUN pip install --no-cache-dir "jupyterlab>=3.0.14" "jupyterlab-kite>=2.0.2" xeus-python supervisor

WORKDIR /tf

COPY supervisord.conf /etc/supervisor/conf.d/

CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]