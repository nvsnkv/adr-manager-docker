FROM node:14-alpine
WORKDIR /app
COPY ["adr-manager", "/app"];
RUN echo "const config = {" > src/config.js
RUN echo "    pizzlyHost: ""PIZZLY_HOST""," >> src/config.js
RUN echo "    pizzlyPublishableKey: ""PIZZLY_PUBLISHABLE_KEY""" >> src/config.js
RUN echo "};" >> src/config.js
RUN echo "export default config;" >> src/config.js
RUN npm -g install static-server
RUN npm install
RUN npm run build
RUN echo "#!/bin/bash"  > entrypoint.sh
RUN echo "sed -i ""s|PIZZLY_HOST|${PIZZY_HOST}|g"" src/config.js" >> entrypoint.sh
RUN echo "sed -i ""s|PIZZLY_PUBLISHABLE_KEY|${PIZZY_PUBLISHABLE_KEY}|g"" src/config.js" >> entrypoint.sh
RUN echo "npm run build" >> entrypoint.sh
RUN echo "cd dist" >> entrypoint.sh
RUN echo "static-server -p 80"

CMD entrypoint.sh





