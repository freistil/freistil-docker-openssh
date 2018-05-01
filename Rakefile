# Image-specific settings
IMAGE_NAME = "freistil/openssh"
RUN_OPTS = "-i -t"

# Determine current Git commit
GIT_SHA = `git rev-parse HEAD`.chomp

task default: :build

desc "Build the image"
task :build do
  sh "docker build -t #{IMAGE_NAME} ."
end

desc "Start a container from the image"
task run: [:build] do
  sh "docker run #{RUN_OPTS} #{IMAGE_NAME}"
end

desc "Run integration tests"
task :test do
  sh "bundle exec rspec spec"
end

desc "Pull the image from Docker Hub"
task :pull do
  sh "docker pull #{IMAGE_NAME}:latest"
end

desc "Push image from CI to Docker Hub"
task push: [:build] do
  sh 'echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin'
  sh "docker tag #{IMAGE_NAME} #{IMAGE_NAME}:#{GIT_SHA}"
  sh "docker push #{IMAGE_NAME}:#{GIT_SHA}"
  sh "docker tag #{IMAGE_NAME} #{IMAGE_NAME}:latest"
  sh "docker push #{IMAGE_NAME}:latest"
end
