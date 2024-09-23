# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

# Install necessary packages (fortune and cowsay)
RUN apt-get update && apt-get install -y fortune cowsay && rm -rf /var/lib/apt/lists/*

# Expose port 4499 to the outside world
EXPOSE 4499

# Set the default command to run the application
CMD ["./wisecow.sh"]

