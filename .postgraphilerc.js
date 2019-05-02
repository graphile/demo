module.exports = {
  options: {
    // Our unprivileged connection string
    connection: "postgres://graphql@localhost/graphile_example",

    // Privileged connection string, we use this for
    // installing the watch fixtures
    ownerConnection: "graphile_example",

    // Respect database permissions
    ignoreRbac: false,

    // Enhance GraphiQL with explorer, headers, prettier, etc
    enhanceGraphiql: true,

    appendPlugins: [
      // Install the simplify inflector for nicer field names
      require("@graphile-contrib/pg-simplify-inflector")
    ],

    skipPlugins: [
      // Disable the Node interface for a smaller schema
      require("graphile-build").NodePlugin
    ]
  }
};
