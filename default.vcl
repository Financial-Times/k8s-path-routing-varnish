vcl 4.0;

# Backend definitions
backend content_public_read {
    .host = "content-public-read";
    .port = "8080";
}

backend enriched_content_read_api {
    .host = "enriched-content-read-api";
    .port = "8080";
}

backend public_things_api {
    .host = "public-things-api";
    .port = "8080";
}

backend content_preview {
    .host = "content-preview";
    .port = "8080";
}

backend notifications_rw {
    .host = "notifications-rw";
    .port = "8080";
}

backend list_notifications_rw {
    .host = "list-notifications-rw";
    .port = "8080";
}

backend document_store_api {
    .host = "document-store-api";
    .port = "8080";
}

backend public_concordances_api {
    .host = "public-concordances-api";
    .port = "8080";
}

backend concept_suggestion_api {
    .host = "concept-suggestion-api";
    .port = "8080";
}

backend public_people_api {
    .host = "public-people-api";
    .port = "8080";
}

backend public_six_degrees_api {
    .host = "public-six-degrees-api";
    .port = "8080";
}

backend public_brands_api {
    .host = "public-brands-api";
    .port = "8080";
}

backend public_organisations_api {
    .host = "public-organisations-api";
    .port = "8080";
}

// TODO: Uncomment this when the internal content api service will be added to the K8S cluster
//backend internal_content_api {
//    .host = "internal-content-api";
//    .port = "8080";
//}


sub vcl_recv {
    if (req.url ~ "^\/content\/notifications\/.*$") {
        set req.backend_hint = notifications_rw;
    }
    elif (req.url ~ "^\/content\/.*$") {
        set req.backend_hint = content_public_read;
    }
    elif (req.url ~ "^\/enrichedcontent\/.*$") {
      set req.backend_hint = enriched_content_read_api;
    }
    elif (req.url ~ "^\/things\/.*$") {
      set req.backend_hint = public_things_api;
    }
    elif (req.url ~ "^\/content-preview\/.*$") {
      set req.backend_hint = content_preview;
    }
    elif (req.url ~ "^\/lists\/notifications.*$") {
      set req.backend_hint = list_notifications_rw;
    }
    elif (req.url ~ "^\/lists.*$") {
      set req.backend_hint = document_store_api;
    }
    elif (req.url ~ "^\/concordances.*$") {
      set req.backend_hint = public_concordances_api;
    }
    elif (req.url ~ "^\/suggest.*$") {
      set req.backend_hint = concept_suggestion_api;
    }
    elif (req.url ~ "^\/people\/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$") {
      set req.backend_hint = public_people_api;
    }
    elif (req.url ~ "^\/sixdegrees\/.*$") {
      set req.backend_hint = public_six_degrees_api;
    }
    elif (req.url ~ "^\/brands\/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$") {
      set req.backend_hint = public_brands_api;
    }
    elif (req.url ~ "^\/organisations\/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$") {
      set req.backend_hint = public_organisations_api;
    }
// TODO: Uncomment this when the internal content api service will be added to the K8S cluster
//    elif (req.url ~ "^\/internalcontent\/.*$") {
//      set req.backend_hint = internal_content_api;
//    }

    return (pipe);
}
