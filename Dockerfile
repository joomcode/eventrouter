# Copyright 2017 Heptio Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM golang:1.13 as builder

#Store this image indefinitely in Joom Artifactory
LABEL com.joom.retention.maxCount=-1

WORKDIR /build
ADD . .
RUN CGO_ENABLED=0 GOOS=linux go build


FROM ubuntu:focal
COPY --from=builder /build/eventrouter /app/

CMD ["/bin/sh", "-c", "/app/eventrouter -v 3 -logtostderr"]
