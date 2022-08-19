// Use https://finicky-kickstart.now.sh to generate basic configuration
// Learn more about configuration options: https://github.com/johnste/finicky/wiki/Configuration

module.exports = {
  defaultBrowser: "Safari",
  options: {
    hideIcon: true,
  },
  rewrite: [
    {
      match: ({ url }) => url.protocol === "http",
      url: { protocol: "https" }
    }
  ],
  handlers: [
    {
      match: [
        "meet.google.com*",
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
      match: [
        finicky.matchDomains(/notion.so/),
        "notion.so/*",
      ],
      browser: "Notion"
    }
  ]
}
