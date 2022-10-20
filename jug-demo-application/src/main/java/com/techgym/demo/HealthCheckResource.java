package com.techgym.demo;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import io.quarkus.logging.Log;
import io.smallrye.mutiny.Uni;

@Path("health")
public class HealthCheckResource {

    // Variable to simulate the liveness probe.
    private static boolean isLive = true;

    // Variable to simulate the readiness probe.
    private static boolean isReady = true;

    @GET
    @Path("live")
    public Uni<Response> liveness() {

        if (isLive)
            Log.info("Liveness status: READY!");
        else
            Log.error("Liveness status: FAILED!");

        var response = isLive ? Response.ok().build() : Response.status(Status.NOT_FOUND).build();
        return Uni.createFrom().item(response);
    }

    @POST
    @Path("/live/kill")
    public void setLiveness() {
        isLive = false;
    }

    @GET
    @Path("ready")
    public Uni<Response> readiness() {

        if (isReady)
            Log.info("Readiness status: READY!");
        else
            Log.error("Readiness status: FAILED!");

        var response = isReady ? Response.ok().build() : Response.status(Status.NOT_FOUND).build();
        return Uni.createFrom().item(response);
    }

    @POST
    @Path("/ready")
    public void setReadiness(@QueryParam("isReady") boolean isReady) {
        HealthCheckResource.isReady = isReady;
    }
}
