# AddSmiley 1.0
# by tsjost

# Usage:
#   The best interface is no interface. There's nothing fancy here, just use it! (And tell me how awesome it is)
#
# Settings:
#   addsmiley_on (ON)
#     ON:  It's on and should do what it should.
#     OFF: The opposite to on.
#
#   addsmiley_smiley (":)")
#     xx:  This is the actual string that's going to be appended to some of your lines.
#
#   addsmiley_percentage (30)
#     xx:  The percentage (probably between and including 0 and 100) of how many lines get a smiley appended.
#
# Notes:
#   Whenever you type your own smiley at the end of the line (/(.(:|=)|(:|=).)$/), we won't put another there.
#

use Irssi;
use vars qw($VERSION %IRSSI);

$VERSION = "1.0";
%IRSSI = (
	authors		=> 'tsjost',
	name		=> 'AddSmiley',
	description	=> 'Adds a smiley to some lines, to make yourself appear less negative.',
	url			=> 'https://github.com/tsjost/AddSmiley'
);

sub event_output_msg {
	if (!Irssi::settings_get_bool("addsmiley_on")) {
		return;
	}
	if (int(rand(101)) > Irssi::settings_get_int("addsmiley_percentage")) {
		return;
	}

	my ($msg, $server, $witem) = @_;

	if ($msg =~ /(.(:|=)|(:|=).)$/) {
		return;
	}
	
	my $smiley = Irssi::settings_get_str("addsmiley_smiley");
		
	$witem->command("MSG ".$witem->{name}." ".$msg." ".$smiley);
	Irssi::signal_stop();
}

Irssi::signal_add("send text", "event_output_msg");

Irssi::settings_add_bool("addsmiley", "addsmiley_on", 1);
Irssi::settings_add_str("addsmiley", "addsmiley_smiley", ":)");
Irssi::settings_add_int("addsmiley", "addsmiley_percentage", 30);
