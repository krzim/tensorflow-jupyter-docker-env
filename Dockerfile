FROM  tensorflow/tensorflow:latest-gpu-jupyter

ENV KITE_ROOT /root/.local/share/kite
WORKDIR $KITE_ROOT

# kite engine for enhanced autocomplete
# COPY --chmod=770 kite-installer.sh ./
# RUN ./kite-installer.sh
COPY --chmod=770 ./kite-updater-2.20210610.0.sh ./
RUN ./kite-updater-2.20210610.0.sh --target $KITE_ROOT/kite-v2.20210610.0/

COPY --chmod=770 ./kited $KITE_ROOT

RUN pip install --no-cache-dir "jupyterlab>=3.0.14" "jupyterlab-kite>=2.0.2" xeus-python supervisor

WORKDIR /tf

COPY supervisord.conf /etc/supervisor/conf.d/

CMD ln -s $KITE_ROOT/kite-v2.20210610.0 $KITE_ROOT/current && /usr/local/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf