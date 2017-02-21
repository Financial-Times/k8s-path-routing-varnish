## UPP Path routing Varnish

The Varnish routing proxy placed after the api-policy-component.
Its role is to route traffic based on the context path in the URL to appropriate services.

See [default.vcl](/default.vcl) for the Varnish routing policies.
