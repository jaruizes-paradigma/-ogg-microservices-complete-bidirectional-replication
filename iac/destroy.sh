#!/bin/bash
set -e

export AWS_ACCESS_KEY_ID=$KEY_ID
export AWS_SECRET_ACCESS_KEY=$SECRET_ID

cd terraform
terraform destroy -auto-approve