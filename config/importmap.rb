# Pin npm packages by running ./bin/importmap

pin "application"
pin "video.js" # @8.21.0
pin "@babel/runtime/helpers/extends", to: "@babel--runtime--helpers--extends.js" # @7.26.0
pin "@videojs/vhs-utils/es/byte-helpers", to: "@videojs--vhs-utils--es--byte-helpers.js" # @4.1.1
pin "@videojs/vhs-utils/es/containers", to: "@videojs--vhs-utils--es--containers.js" # @4.1.1
pin "@videojs/vhs-utils/es/decode-b64-to-uint8-array", to: "@videojs--vhs-utils--es--decode-b64-to-uint8-array.js" # @4.1.1
pin "@rails/ujs", to: "https://cdn.jsdelivr.net/npm/@rails/ujs@7.1.3-4/app/assets/javascripts/rails-ujs.min.js"
