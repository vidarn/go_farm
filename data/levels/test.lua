return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "isometric",
  width = 40,
  height = 40,
  tilewidth = 32,
  tileheight = 16,
  properties = {},
  tilesets = {
    {
      name = "block",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "../tiles/block.png",
      imagewidth = 1920,
      imageheight = 1147,
      tileoffset = {
        x = 0,
        y = 16
      },
      properties = {},
      tiles = {
        {
          id = 0,
          properties = {
            ["digable"] = "true",
            ["pathable"] = "true"
          }
        },
        {
          id = 1,
          properties = {
            ["digable"] = "true",
            ["pathable"] = "true"
          }
        },
        {
          id = 2,
          properties = {
            ["collision"] = "true"
          }
        },
        {
          id = 60,
          properties = {
            ["digable"] = "true",
            ["pathable"] = "true"
          }
        },
        {
          id = 61,
          properties = {
            ["digable"] = "true",
            ["pathable"] = "true"
          }
        },
        {
          id = 62,
          properties = {
            ["plantable"] = "true"
          }
        },
        {
          id = 64,
          properties = {
            ["hoeable"] = "true"
          }
        },
        {
          id = 120,
          properties = {
            ["digable"] = "true",
            ["pathable"] = "true"
          }
        },
        {
          id = 121,
          properties = {
            ["digable"] = "true",
            ["pathable"] = "true"
          }
        },
        {
          id = 122,
          properties = {
            ["digable"] = "true",
            ["pathable"] = "true"
          }
        },
        {
          id = 123,
          properties = {
            ["digable"] = "true",
            ["pathable"] = "true"
          }
        },
        {
          id = 181,
          properties = {
            ["collision"] = "true",
            ["pathable"] = "true"
          }
        },
        {
          id = 182,
          properties = {
            ["digable"] = "true",
            ["pathable"] = "true"
          }
        },
        {
          id = 183,
          properties = {
            ["digable"] = "true",
            ["pathable"] = "true"
          }
        }
      }
    },
    {
      name = "objects",
      firstgid = 2101,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "../tiles/objects.png",
      imagewidth = 160,
      imageheight = 128,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      tiles = {
        {
          id = 0,
          properties = {
            ["collision"] = "true",
            ["interactable_type"] = "ball",
            ["spawn"] = "interactable"
          }
        },
        {
          id = 1,
          properties = {
            ["collision"] = "true",
            ["interactable_type"] = "tree"
          }
        },
        {
          id = 2,
          properties = {
            ["collision"] = "true",
            ["interactable_type"] = "shop"
          }
        },
        {
          id = 3,
          properties = {
            ["collision"] = "true",
            ["interactable_type"] = "market"
          }
        },
        {
          id = 4,
          properties = {
            ["interactable_type"] = "sunflower_seed"
          }
        },
        {
          id = 5,
          properties = {
            ["interactable_type"] = "shovel_dev"
          }
        },
        {
          id = 6,
          properties = {
            ["interactable_type"] = "shovel_iron"
          }
        },
        {
          id = 7,
          properties = {
            ["interactable_type"] = "hoe_iron"
          }
        },
        {
          id = 10,
          properties = {
            ["interactable_type"] = "sunflower_seed"
          }
        },
        {
          id = 11,
          properties = {
            ["interactable_type"] = "berry_bush_seed"
          }
        },
        {
          id = 15,
          properties = {
            ["interactable_type"] = "pathway"
          }
        }
      }
    },
    {
      name = "fence",
      firstgid = 2121,
      tilewidth = 32,
      tileheight = 48,
      spacing = 0,
      margin = 0,
      image = "../tiles/fence.png",
      imagewidth = 64,
      imageheight = 144,
      tileoffset = {
        x = 0,
        y = 16
      },
      properties = {},
      tiles = {
        {
          id = 0,
          properties = {
            ["collision"] = "true"
          }
        },
        {
          id = 1,
          properties = {
            ["collision"] = "true"
          }
        },
        {
          id = 2,
          properties = {
            ["collision"] = "true"
          }
        },
        {
          id = 3,
          properties = {
            ["collision"] = "true"
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "ground",
      x = 0,
      y = 0,
      width = 40,
      height = 40,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 61, 61, 61, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 182, 182, 182, 182, 182, 182, 182, 182, 182, 182, 62, 61, 61, 61, 61, 3, 3, 3,
        3, 3, 3, 3, 3, 0, 2, 61, 0, 62, 61, 183, 62, 124, 1, 62, 183, 62, 62, 62, 62, 62, 62, 182, 182, 182, 182, 182, 182, 182, 182, 61, 61, 62, 61, 61, 61, 61, 3, 3,
        3, 3, 3, 3, 62, 2, 2, 2, 2, 62, 62, 2, 2, 2, 2, 183, 62, 183, 123, 2, 123, 62, 181, 181, 181, 181, 181, 181, 181, 181, 181, 61, 62, 124, 61, 62, 123, 61, 3, 3,
        3, 3, 3, 62, 62, 62, 184, 61, 2, 124, 2, 62, 1, 61, 2, 62, 62, 62, 1, 61, 2, 62, 62, 182, 182, 182, 182, 182, 182, 182, 62, 61, 183, 61, 123, 123, 61, 61, 3, 3,
        3, 3, 3, 2, 123, 61, 62, 2, 61, 2, 62, 1, 62, 2, 61, 2, 62, 1, 62, 2, 61, 2, 182, 182, 182, 182, 182, 182, 182, 182, 61, 183, 62, 61, 61, 61, 184, 61, 3, 3,
        3, 3, 3, 61, 2, 2, 122, 1, 2, 1, 62, 61, 1, 1, 2, 1, 62, 61, 123, 1, 2, 1, 182, 182, 62, 62, 62, 0, 0, 182, 62, 61, 61, 61, 61, 62, 61, 61, 3, 3,
        3, 3, 3, 3, 3, 121, 121, 122, 2, 61, 2, 1, 2, 65, 65, 65, 65, 1, 2, 62, 2, 124, 2, 182, 62, 124, 62, 0, 0, 0, 182, 61, 61, 62, 122, 61, 184, 61, 3, 3,
        3, 3, 3, 3, 61, 62, 121, 122, 1, 184, 2, 2, 2, 65, 65, 65, 65, 2, 2, 1, 1, 62, 2, 2, 2, 1, 1, 124, 62, 182, 182, 182, 61, 122, 121, 122, 61, 61, 3, 3,
        3, 3, 3, 2, 1, 2, 123, 2, 2, 62, 62, 2, 2, 65, 65, 65, 65, 2, 2, 2, 184, 62, 62, 2, 2, 124, 124, 62, 62, 182, 0, 3, 3, 61, 122, 122, 62, 3, 3, 3,
        3, 3, 3, 62, 124, 61, 123, 1, 2, 124, 62, 62, 1, 65, 65, 65, 65, 62, 1, 61, 2, 62, 124, 62, 1, 61, 2, 124, 62, 182, 3, 0, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 1, 2, 61, 2, 123, 2, 61, 2, 62, 2, 62, 2, 181, 2, 62, 61, 62, 123, 61, 2, 62, 62, 62, 2, 61, 2, 62, 182, 182, 182, 182, 3, 3, 3, 3, 3, 3, 3,
        3, 1, 2, 1, 62, 61, 1, 123, 61, 1, 61, 61, 1, 1, 181, 1, 62, 61, 184, 1, 2, 1, 182, 61, 182, 182, 61, 2, 61, 61, 61, 182, 182, 182, 3, 3, 3, 3, 3, 3,
        3, 62, 2, 61, 2, 1, 1, 183, 2, 1, 123, 62, 2, 181, 181, 181, 2, 124, 2, 62, 2, 182, 182, 182, 182, 182, 182, 62, 181, 1, 61, 182, 182, 182, 3, 3, 3, 3, 3, 3,
        3, 1, 124, 62, 2, 2, 62, 124, 62, 1, 1, 2, 124, 181, 181, 181, 2, 2, 2, 1, 182, 182, 182, 182, 182, 182, 182, 182, 181, 182, 182, 182, 182, 182, 3, 3, 3, 3, 3, 3,
        3, 3, 2, 62, 62, 183, 61, 2, 2, 1, 123, 62, 123, 181, 181, 181, 62, 2, 2, 182, 182, 182, 62, 2, 182, 182, 182, 62, 181, 62, 62, 62, 182, 182, 3, 3, 3, 3, 3, 3,
        3, 62, 2, 62, 124, 2, 1, 61, 123, 62, 183, 1, 123, 61, 181, 62, 62, 62, 1, 182, 182, 62, 1, 1, 124, 182, 62, 62, 61, 62, 61, 62, 182, 182, 3, 3, 3, 3, 3, 3,
        3, 62, 61, 2, 62, 61, 62, 2, 1, 2, 62, 1, 62, 1, 181, 2, 184, 62, 184, 2, 182, 2, 2, 1, 2, 182, 62, 62, 62, 61, 61, 61, 182, 182, 3, 3, 3, 3, 3, 3,
        3, 1, 3, 1, 62, 61, 1, 1, 1, 1, 62, 61, 1, 1, 181, 1, 62, 61, 1, 1, 182, 182, 184, 2, 182, 182, 62, 61, 61, 124, 62, 2, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 1, 3, 61, 183, 1, 2, 1, 1, 61, 2, 1, 2, 181, 181, 61, 2, 1, 2, 182, 182, 182, 182, 182, 182, 182, 62, 2, 62, 123, 2, 62, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 1, 3, 62, 2, 2, 1, 2, 0, 0, 2, 124, 2, 181, 2, 182, 182, 182, 182, 182, 182, 182, 182, 182, 182, 61, 61, 61, 61, 123, 2, 62, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 1, 3, 62, 62, 2, 2, 2, 0, 0, 62, 2, 2, 181, 2, 182, 2, 2, 2, 182, 182, 182, 1, 2, 1, 2, 62, 2, 2, 1, 62, 61, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 1, 3, 3, 62, 62, 1, 61, 2, 62, 62, 62, 124, 181, 2, 182, 62, 62, 1, 61, 182, 1, 1, 62, 62, 123, 183, 184, 2, 123, 61, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 1, 1, 3, 3, 2, 184, 2, 61, 2, 62, 62, 62, 181, 61, 182, 62, 62, 62, 2, 61, 1, 1, 62, 61, 62, 62, 1, 61, 123, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 1, 1, 3, 1, 62, 1, 61, 183, 2, 123, 61, 181, 2, 182, 184, 62, 1, 2, 62, 61, 1, 1, 62, 2, 123, 1, 62, 1, 61, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 62, 1, 1, 0, 61, 1, 2, 122, 2, 1, 62, 62, 181, 2, 182, 62, 62, 2, 181, 181, 181, 1, 123, 183, 62, 184, 1, 61, 61, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 1, 3, 3, 3, 3, 2, 121, 122, 122, 2, 62, 61, 181, 181, 181, 181, 181, 181, 181, 181, 181, 61, 2, 2, 61, 184, 2, 61, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 1, 3, 3, 3, 3, 2, 2, 122, 121, 184, 184, 1, 62, 2, 182, 2, 1, 61, 181, 181, 181, 62, 1, 61, 61, 2, 2, 61, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 1, 1, 3, 3, 3, 3, 2, 61, 62, 184, 184, 2, 61, 123, 182, 61, 183, 183, 61, 1, 62, 1, 2, 2, 62, 2, 124, 61, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 61, 1, 3, 3, 3, 3, 3, 2, 62, 184, 183, 61, 1, 182, 1, 2, 124, 61, 2, 62, 61, 184, 61, 61, 62, 62, 62, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 3, 2, 1, 3, 3, 3, 3, 3, 1, 1, 2, 61, 2, 182, 1, 183, 2, 1, 1, 2, 2, 184, 183, 1, 62, 3, 3, 3, 3, 3, 1, 1, 2, 61, 3, 3, 3, 3,
        3, 3, 3, 3, 62, 62, 61, 3, 3, 3, 3, 3, 1, 1, 1, 182, 61, 62, 2, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 62, 61, 61, 61, 61, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 61, 61, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 61, 182, 182, 182, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 62, 62, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 61, 2, 182, 61, 61, 2, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 62, 61, 2, 61, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 61, 1, 62, 62, 61, 1, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 62, 61, 3, 3, 3, 3, 3, 62, 2, 62, 2, 62, 62, 3, 3, 3, 1, 1, 61, 2, 1, 2, 1, 61, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 2, 2, 61, 3, 3, 3, 3, 1, 1, 61, 62, 2, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
      }
    },
    {
      type = "tilelayer",
      name = "other",
      x = 0,
      y = 0,
      width = 40,
      height = 40,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2121, 2121, 2121, 2121, 2121, 2121, 2121, 2124, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2123, 2121, 2121, 2121, 2121, 2121, 2124, 2123, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2123, 2123, 0, 0, 0, 0, 2124, 2123, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2123, 2123, 0, 0, 0, 0, 2124, 2123, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2123, 2123, 0, 0, 0, 0, 2124, 2123, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2123, 2123, 0, 0, 0, 0, 0, 2123, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2123, 2123, 2122, 0, 2121, 2121, 2123, 2123, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2123, 2122, 2122, 0, 2121, 2121, 2121, 2123, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2126, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2125, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 2124, 2122, 2122, 2122, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 2124, 0, 0, 2123, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 2124, 0, 0, 2123, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 2121, 2121, 2121, 2123, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2121, 2121, 2121, 2124, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2124, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2124, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2124, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2121, 2122, 2122, 2122, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "objects",
      x = 0,
      y = 0,
      width = 40,
      height = 40,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2111, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 2102, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2102, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 2111, 0, 0, 0, 0, 0, 0, 0, 0, 2103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2111, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2104, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 2102, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2111, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2111, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
