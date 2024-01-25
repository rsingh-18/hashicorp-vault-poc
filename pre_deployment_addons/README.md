# Overview

This directory contains `terraform` script / modules which can be used to create necessary prerequisite `AWS / kubectl resources` for a successful IAM backend deployment in EKS.

# Prerequisite
Follow [fiesta_addons/iam_custom_addons](https://github.com/philips-internal/HSP_PS_IAMDEVOPS/tree/fr_721_fiesta/fiesta_addons/iam_custom_addons) before proceeding with implementation of this module

## Project / Directory Structure
```
.
├── backends.tf
├── datasources.tf
├── dev.conf
├── locals.tf
├── main.tf
├── modules
│   ├── iam-resources
│   │   ├── adminuser.tf
│   │   ├── locals.tf
│   │   ├── outputs.tf
│   │   ├── s3user.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   ├── namespace
│   │   ├── clusterrolebindings.tf
│   │   ├── locals.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── roles.tf
│   │   ├── serviceaccount.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   ├── rds
│   │   ├── locals.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   └── s3bucket
│       ├── locals.tf
│       ├── main.tf
│       ├── outputs.tf
│       ├── variables.tf
│       └── versions.tf
├── outputs.tf
├── provider.tf
├── README.md
├── terraform.tfvars.example
├── variables.tf
└── versions.tf
```

## Resources / Modules Overview

<table>
  <tr align="center">
    <th>Resource / Modules</th>
    <th>Purpose</th>
    <th>Default Flag Name</th>
    <th>Default Flag Value</th>
    <th>Depends on</th>
    <th>Remarks</th>
  </tr>
  <tr>
    <th>Namespace</th>
    <td>To create new namespace, service account and rolebinding</td>
    <td>enable_namespace_creation</td>
    <td>false</td>
    <td>N/A</td>
    <td>
      <ul>
        <li>Update <b>enable_namespace_creation</b> to <i>true</i> in <u>variables.tf</u> in case namespace doesn't exist</li>
        <li>To build this module, as a prerequisite, a ClusterRole needs to be existing - <a href="https://github.com/philips-internal/HSP_PS_IAMDEVOPS/tree/k8s_ds712_fiesta/fiesta_addons/access_control#prerequisite" target="_blank">fiesta_addons/access_control</a></li>
      </ul>
    </td>
  </tr>
  <tr>
    <th>S3 Bucket</th>
    <td>To create new bucket using crossplane API</td>
    <td>enable_bucket_creation</td>
    <td>true</td>
    <td>
      N/A<br/>
      <b>Note</b>: In case, namespace creation is enabled, this should depend on namespace.
    </td>
    <td>Update <b>enable_bucket_creation</b> to <i>false</i> in <u>variables.tf</u> in order to skip bucket creation</td>
  </tr>
  <tr>
    <th>IAM Resources</th>
    <td>To create <b>AWS IAM users</b>, <b>assigning policies</b> and generate their <b>access keys</b> using crossplane API</td>
    <td>enable_iam_resource_creation</td>
    <td>true</td>
    <td>S3 Bucket</td>
    <td>Update <b>enable_iam_resource_creation</b> to <i>false</i> in <u>variables.tf</u> in order to skip creation of IAM resources</td>
  </tr>
  <tr>
    <th>RDS Instance</th>
    <td>To create new RDS Instance using crossplane API</td>
    <td>enable_rds_creation</td>
    <td>true</td>
    <td>
      N/A<br/>
      <b>Note</b>: In case, namespace creation is enabled, this should depend on namespace.
    </td>
    <td>
      <ul>
        <li>Update <b>enable_rds_creation</b> to <i>false</i> in <u>variables.tf</u> in order to skip creation of new RDS Instance</li>
        <li>To disable automated backups, set <b>backupRetentionPeriod = 0</b> in <a href="https://github.com/philips-internal/HSP_PS_IAMDEVOPS/blob/k8s_ds712_fiesta/fiesta_addons/pre_deployment_addons/modules/rds/locals.tf" target="_blank">locals.tf</a></li>
      </ul>
    </td>
  </tr>
</table>

> :information_source: **Remark**: Module `iam-resources` creates one user with name `${var.namespace}-admin-user`. The credentials of this user are supposed to be used in the Jenkins pipeline. Before we can use, we will have to map this user to the `aws-auth` configmap in `kube-system` namespace. This configuration will have to be *manually* done.

## Variables / Input Parameters Description

<table>
  <tr align="center">
    <th>Name</th>
    <th>Description</th>
    <th>Default Value</th>
    <th>References</th>
  </tr>
  <tr>
    <th>profile</th>
    <td>AWS profile</td>
    <td>--</td>
    <td>
        <ul>
            <li>terraform <i>kubectl</i> provider</li>
            <li>s3bucket module</li>
            <li>rds module</li>
        </ul>
    </td>
  </tr>
  <tr>
    <th>region</th>
    <td>AWS region</td>
    <td>--</td>
    <td>
        <ul>
            <li>terraform <i>kubectl</i> provider</li>
            <li>s3bucket module</li>
            <li>rds module</li>
        </ul>
    </td>
  </tr>
  <tr>
    <th>cluster_name</th>
    <td>EKS cluster name</td>
    <td>--</td>
    <td>
        <ul>
            <li>terraform <i>kubectl</i> provider to <b>identify host</b>, <b>cluster certificate</b> and generate <b>token</b></li>
        </ul>
    </td>
  </tr>
  <tr>
    <th>namespace</th>
    <td>namespace to be created and to be used as naming identifier for resources</td>
    <td>--</td>
    <td>
        <ul>
            <li>namespace module</li>
            <li>s3bucket module</li>
            <li>iam-resources module</li>
            <li>rds module</li>
        </ul>
    </td>
  </tr>
  <tr>
    <th>objects_expiration_days</th>
    <td>number of days beyond which data in s3 bucket will not be retained</td>
    <td>14</td>
    <td rowspan="1">
        <ul>
            <li>s3bucket module</li>
        </ul>
    </td>
  </tr>
  <tr>
    <th>s3policyArn</th>
    <td>ARN of the policy to be attached to the user to access s3 buckets</td>
    <td>provided in terraform.tfvars.example</td>
    <td rowspan="2">
        <ul>
            <li>iam-resources module</li>
        </ul>
    </td>
  </tr>
  <tr>
    <th>admin_user_policyArn</th>
    <td>ARN of the policy to be attached to the user with admin access. The same user can be used to run deployments, create Cloudwatch resources, SNS resources, Lambda resources, etc.</td>
    <td>provided in terraform.tfvars.example</td>
  </tr>
  <tr>
    <th>rds_ca_certificate_identifier</th>
    <td>Certificate Authority for RDS</td>
    <td>--</td>
    <td rowspan="18">
        <ul>
            <li>rds module</li>
        </ul>
    </td>
  </tr>
  <tr>
    <th>allocatedStorage</th>
    <td>minimum allocated storage for RDS instance</td>
    <td>50</td>
  </tr>
  <tr>
    <th>allowMajorVersionUpgrade</th>
    <td>flag to determine whether to allow major version upgrade</td>
    <td>false</td>
  </tr>
  <tr>
    <th>applyImmediately</th>
    <td>flag to determine if changes to be applied immediately</td>
    <td>true</td>
  </tr>
  <tr>
    <th>autoGeneratePassword</th>
    <td>flag to determine if to generate a random password for RDS user</td>
    <td>true</td>
  </tr>
  <tr>
    <th>autoMinorVersionUpgrade</th>
    <td>flag to determine if minor version upgrades to be applied immediately</td>
    <td>true</td>
  </tr>
  <tr>
    <th>maxAllocatedStorage</th>
    <td>maximum allocated storage for RDS instance</td>
    <td>100</td>
  </tr>
  <tr>
    <th>backupRetentionPeriod</th>
    <td>Number of days beyond which backups would not be stored. When set to 0, automated backups are disabled</td>
    <td>0</td>
  </tr>
  <tr>
    <th>copyTagsToSnapshot</th>
    <td>flag to determine if tags are to be applied to snapshots</td>
    <td>true</td>
  </tr>
  <tr>
    <th>multiAz</th>
    <td>flag to determine if RDS instance is multiAZ</td>
    <td>false</td>
  </tr>
  <tr>
    <th>dbInstanceClass</th>
    <td>Instance class type of the RDS instance</td>
    <td>db.m5.large</td>
  </tr>
  <tr>
    <th>engine</th>
    <td>engine name of the RDS instance</td>
    <td>postgres</td>
  </tr>
  <tr>
    <th>engineVersion</th>
    <td>engine version of the RDS instance</td>
    <td>14</td>
  </tr>
  <tr>
    <th>port</th>
    <td>port number of the RDS instance</td>
    <td>5432</td>
  </tr>
  <tr>
    <th>publiclyAccessible</th>
    <td>flag to determine if RDS instance is publicly accessible</td>
    <td>false</td>
  </tr>
  <tr>
    <th>skipFinalSnapshot</th>
    <td>flag to determine if final snapshot creation to be skipped before deletion</td>
    <td>true</td>
  </tr>
  <tr>
    <th>storageEncrypted</th>
    <td>flag to determine if RDS storage instance is encrypted or not</td>
    <td>true</td>
  </tr>
  <tr>
    <th>storageType</th>
    <td>storage class type of the RDS instance</td>
    <td>gp2</td>
  </tr>
</table>

> :information_source: **Note**: To override any default values, update `terraform.tfvars`

## Execution

> **Note**: Go through [TFSTATEVERSIONING documentation](https://github.com/philips-internal/HSP_PS_IAMDEVOPS/blob/fr_721_fiesta/TFSTATEVERSIONING.md) before proceeding with implementation on how to configure `dev.conf`

1. Modify module flags wrt requirement
2. Create a file named `terraform.tfvars` in the root directory in `key=value` pairs and make an entry for all the parameters listed above, e.g.,
```
region       = "us-east-1"
cluster_name = "aft-XXXXXXXXXX-cluster"
...
...
```
> :warning: **Note**: If we do not create `.tfvars` file, `terraform plan` command will prompt for each of the user inputs during execution
3. Execute the following commands one-by-one:
```
terraform init -backend-config=dev.conf
terraform plan
terraform apply
```

> :information_source: In case we want to save the plan (to avoid prompts for user inputs), execute:
```
terraform plan -out=<plan_name>
terraform apply "<plan_name>"
```
> :warning: Update `<plan_name>` before executing.

To destroy the resources, execute:
```
terraform destroy
```

## AWS Upbound Resources

As part of latest fiesta updates, `crossplane` provider has been replaced with `aws upbound` provider which gets created as a CRD (`apiVersion: pkg.crossplane.io`). As a result, all managed objects have been updated with the same. The following guide will help in understading the changes:

```sh
# resource type that gets created as part of s3bucket module
bucket.s3.aws.upbound.io
bucketlifecycleconfiguration.s3.aws.upbound.io
bucketpublicaccessblock.s3.aws.upbound.io
bucketpolicy.s3.aws.upbound.io

# resource type that gets created as part of iam-resources module
user.iam.aws.upbound.io
userpolicyattachment.iam.aws.upbound.io
accesskey.iam.aws.upbound.io

## retrieving credentials for user
### username
kubectl get accesskey.iam.aws.upbound.io/<access-key-name> -o json | jq .status.atProvider.id | tr -d '"' | tr -d "\n"
### password
kubectl -n <namespace> get secrets <secret-name> --template='{{ index .data "attribute.secret"}}' | base64 -d

# resource type that gets created as part of rds module
instance.rds.aws.upbound.io

## retrieving credentials for rds
### master password
kubectl -n <namespace> get secret <secret-name> --template={{.data.password}} | base64 -d
```

> :information_source: Execute, `kubectl get <resource_type>` to retrieve resources

> :information_source: Guide to crossplane managed resources can be found [here](https://github.com/philips-internal/HSP_PS_IAMDEVOPS/tree/k8s_ds712_fiesta/fiesta_addons#overview)