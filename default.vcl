vcl 4.0;

import dynamic;

# Dummy definitions as we're using dynamic backend declaration
backend default {
    .host = "localhost";
    .port = "8888";
}

sub vcl_init {
    new dynBackend = dynamic.director(port = "8080");
}

sub vcl_recv {
    if (req.url ~ "^\/content\/notifications\/.*$") {
        set req.backend_hint = dynBackend.backend("notifications-rw");
    }
    elif (req.url ~ "^\/content\/.*$") {
        set req.backend_hint = dynBackend.backend("content-public-read");
    }
    elif (req.url ~ "^\/enrichedcontent\/.*$") {
        set req.backend_hint = dynBackend.backend("enriched-content-read-api");
    }
    elif (req.url ~ "^\/things\/.*$") {
        set req.backend_hint = dynBackend.backend("public-things-api");
    }
    elif (req.url ~ "^\/content-preview\/.*$") {
        set req.backend_hint = dynBackend.backend("content-preview");
    }
    elif (req.url ~ "^\/lists\/notifications.*$") {
        set req.backend_hint = dynBackend.backend("list-notifications-rw");
    }
    elif (req.url ~ "^\/lists.*$") {
        set req.backend_hint = dynBackend.backend("document-store-api");
    }
    elif (req.url ~ "^\/concordances.*$") {
        set req.backend_hint = dynBackend.backend("public-concordances-api");
    }
    elif (req.url ~ "^\/suggest.*$") {
        set req.backend_hint = dynBackend.backend("concept-suggestion-api");
    }
    elif (req.url ~ "^\/people\/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$") {
        set req.backend_hint = dynBackend.backend("public-people-api");
    }
    elif (req.url ~ "^\/sixdegrees\/.*$") {
        set req.backend_hint = dynBackend.backend("public-six-degrees-api");
    }
    elif (req.url ~ "^\/brands\/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$") {
        set req.backend_hint = dynBackend.backend("public-brands-api");
    }
    elif (req.url ~ "^\/organisations\/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$") {
        set req.backend_hint = dynBackend.backend("public_organisations_api");
    }
    elif (req.url ~ "^\/internalcontent\/.*$") {
        set req.backend_hint = dynBackend.backend("internal-content-api");
    }
    elif (req.url ~ "^\/__[\w-]*\/.*$") {
        # create a new backend dynamically to match the requested URL that will be looked up in the Kubernetes DNS.
        # For example calling the URL /__content-ingester/xyz will forward the request to the service content-ingester with the url /xyz

        set req.backend_hint = dynBackend.backend(regsub(req.url, "^\/__([\w-]*)\/.*$", "\1"));
        set req.url = regsub(req.url, "^\/__[\w-]*\/(.*)$", "/\1");
        set req.http.X-VarnishPassThrough = "true";
    }

    return (pipe);
}
