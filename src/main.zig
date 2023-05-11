const std = @import("std");

pub fn main() !void {
    var rand = std.rand.DefaultPrng.init(@intCast(u64, std.time.nanoTimestamp()));
    const number: i32 = rand.random().intRangeAtMost(i32, 0, 100);

    var reader = std.io.getStdIn().reader();
    var buf: [64]u8 = undefined;

    while (true) {
        print("Guess a number between 0 and 100:\n", .{});
        const size = try reader.read(&buf) - 2; // delete carriage return
        var guess = try std.fmt.parseInt(i32, buf[0..size], 10);

        if (number < guess)
            print("Guess is too high.\n", .{});

        if (number > guess)
            print("Guess is too low.\n", .{});

        if (number == guess) {
            print("Correct! You win!\n", .{});
            break;
        }
    }
}

fn print(comptime format: []const u8, args: anytype) void {
    var writer = std.io.getStdOut().writer();
    writer.print(format, args) catch {};
}

test "simple test" {}
