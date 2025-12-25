# Use the AWS official Lambda Python runtime image
FROM public.ecr.aws/lambda/python:3.11

# Copy requirements.txt
COPY requirements.txt ${LAMBDA_TASK_ROOT}

# Install the specified packages
RUN pip install -r requirements.txt

# Copy the app code into the container
COPY app/ ${LAMBDA_TASK_ROOT}/app/

# Set the CMD to your handler (file_name.variable_name)
CMD [ "app.main.handler" ]