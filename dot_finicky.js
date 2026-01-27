// Use https://finicky-kickstart.now.sh to generate basic configuration
// Learn more about configuration options: https://github.com/johnste/finicky/wiki/Configuration-(v4)

export default {
  defaultBrowser: "Google Chrome",
  options: {
    hideIcon: true,
    // hideIcon: false,
    // logRequests: true
  },
  rewrite: [
    {
      match: ({ url }) => url.protocol === "http" && url.host !== "localhost",
      url: (url) => {
        url.protocol = "https";
        return url;
      },
    },
  ],
  handlers: [
    {
      match: ["meet.google.com*", "localhost:*"],
      browser: "Google Chrome",
    },
    {
      match: [
        "zoom.us/j/*",
        finicky.matchHostnames(/.*\.zoom.us/),
        /zoom.us\/j\//,
      ],
      browser: "us.zoom.xos",
    },
    {
      match: "open.spotify.com/*",
      browser: "Spotify",
    },
    {
      match: ({ url }) =>
        url.host.endsWith("notion.so") &&
        !url.host.startsWith("calendar") &&
        !url.host.startsWith("file") &&
        !url.pathname.startsWith("/initiateExternalAuthenticationFromDesktop"),
      browser: "Notion",
    },
    {
      match: "linear.app/*",
      browser: "Linear",
    },
    {
      match: "figma.com/*",
      browser: "Figma",
    },
  ],
};
