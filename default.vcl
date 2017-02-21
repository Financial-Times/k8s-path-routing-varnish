vcl 4.0;

# Default backend definition. Set this to point to your content server.
backend content_public_read {
    .host = "content-public-read";
    .port = "8080";
}

sub vcl_recv {
    if (req.url ~ "^\/content\/*$") {
        set req.backend_hint = content_public_read;
        return (pipe);
    }
}
