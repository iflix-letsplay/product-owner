FROM ruby:2.3.1
ADD * /workspace/
RUN apt-get update
RUN apt-get -y install curl
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash
RUN apt-get -y install nodejs
RUN npm install mdpdf@1.7.3 -g
ENTRYPOINT ["/workspace/release-pdf.sh"]
CMD [ ]
