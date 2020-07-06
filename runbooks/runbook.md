<!--
    Written in the format prescribed by https://github.com/Financial-Times/runbook.md.
    Any future edits should abide by this format.
-->

# UPP Path routing Varnish

The of the service is to route traffic based on the context path in the URL to appropriate services.

## Code

k8s-path-routing-varnish

## Service Tier

Platinum

## Lifecycle Stage

Production

## Delivered By

content

## Supported By

content

## Known About By

- hristo.georgiev
- mihail.mihaylov
- kalin.arsov
- boyko.boykov
- donislav.belev
- dimitar.terziev

## Host Platform

AWS

## Architecture

The service lives in Delivery cluster and gets requests from delivery-varnish and it's role is to route these requests to the appropriate services based on rules set in file named [default.vcl](https://github.com/Financial-Times/k8s-path-routing-varnish/blob/master/default.vcl).

## Contains Personal Data

No

## Contains Sensitive Data

No

## Dependencies

delivery-varnish

## Failover Architecture Type

NotApplicable

## Failover Process Type

NotApplicable

## Failback Process Type

NotApplicable

## Failover Details

The purpose of the service is to route traffic to the appropriate services so failover to another cluster is not applicable.

## Data Recovery Process Type

NotApplicable

## Release Process Type

PartiallyAutomated

## Rollback Process Type

Manual

## Release Details

Failover is needed when deploying a new version as this will disconnect the services routed through path-routing-varnish

## Key Management Process Type

NotApplicable

## Key Management Details

No keys are used

## Monitoring

None

## First Line Troubleshooting

<https://github.com/Financial-Times/upp-docs/tree/master/guides/ops/first-line-troubleshooting>

## Second Line Troubleshooting

Please refer to the GitHub repository README for troubleshooting information.
