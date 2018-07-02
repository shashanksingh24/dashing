FROM registry.naspersclassifieds.com/panamera/shakti:latest
ADD dashboard/. /opt/
WORKDIR /opt/
RUN bundle install
CMD ["dashing", "start"]
