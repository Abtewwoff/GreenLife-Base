_GreenLifeBuckets = {}

local __instance = {
    __index = _GreenLifeBuckets
}

setmetatable(_GreenLifeBuckets, {
    __call = function(_, BucketId)
        local self = setmetatable({}, __instance)

        self.bucket = BucketId

        self.playersInBuckets = {}
        self.objectsInBuckets = {}

        --Functions
        exportMetatable(_GreenLifeBuckets, self)

        return (self)
    end
})