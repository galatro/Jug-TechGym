package com.techgym.demo;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

import org.eclipse.microprofile.config.inject.ConfigProperty;

import io.smallrye.mutiny.Uni;

@Path("/version")
public class VersionResource {

    // Resource color.
    private static final String version = "V1.0"; // V1.1;

    @ConfigProperty(name = "HOSTNAME", defaultValue = "localhost")
    private String hostname; 

    @GET
    public Uni<String> version() {
        return Uni.createFrom()
            .item("From $HOSTNAME: $VERSION version!").onItem()
            .transform(item -> item.replace("$HOSTNAME", hostname).replace("$VERSION", version));
    }
}
