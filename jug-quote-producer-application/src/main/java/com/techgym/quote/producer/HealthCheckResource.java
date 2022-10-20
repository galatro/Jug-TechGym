package com.techgym.quote.producer;

import javax.enterprise.context.ApplicationScoped;
import javax.ws.rs.core.Response;

import org.eclipse.microprofile.health.Liveness;
import org.eclipse.microprofile.health.Readiness;

@ApplicationScoped
public class HealthCheckResource {
    
    @Liveness
    public Response liveness() {
        return Response.ok().build();
    }

    @Readiness
    public Response readiness() {
        return Response.ok().build();
    }
}

