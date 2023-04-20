// Entry point for the build script in your package.json

// Figure out why Bootstrap JS hates me later.

import jquery from 'jquery';

window.jQuery = jquery;
window.$ = jquery;

import * as bootstrap from "bootstrap";

import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false

console.log({ bootstrap, jquery })

console.log("HIT")
