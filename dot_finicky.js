// Use https://finicky-kickstart.now.sh to generate basic configuration
// Learn more about configuration options: https://github.com/johnste/finicky/wiki/Configuration

module.exports = {
  defaultBrowser: "Safari",
  options: {
    hideIcon: true,
    // hideIcon: false,
    // logRequests: true
  },
  rewrite: [
    {
      match: ({ url }) => url.protocol === "http" && url.host !== "localhost",
      url: { protocol: "https" }
    }
  ],
  handlers: [
    {
      match: [
        "meet.google.com*",
        "localhost:*"
      ],
      browser: "Google Chrome"
    },
    {
      match: [
        "zoom.us/j/*",
        finicky.matchDomains(/.*\zoom.us\/j/),
        /zoom.us\/j\//,
      ],
      browser: "us.zoom.xos"
    },
    {
      match: "open.spotify.com/*",
      browser: "Spotify"
    },
    {
      match: ({ url }) => url.host.endsWith("notion.so") &&
        !url.host.startsWith("calendar") &&
        !url.pathname.startsWith("/initiateExternalAuthenticationFromDesktop"),
      browser: "Notion"
    },
    {
      match: /^https?:\/\/.*\.slack\.com\/archives\/.*$/,
      browser: "Slack"
    }
  ]
}
