package com.techgym.demo;

import java.time.LocalTime;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;

@Path("cpu")
public class CpuLoadResource {

    @GET
    @Path("load")
    public Response load() {

        LocalTime endAt = LocalTime.now().plusSeconds(30);

        while (true) {
            
            if (LocalTime.now().isAfter(endAt))
                break;

            System.out.print("");
        }

        return Response.ok().build();
    }
}
