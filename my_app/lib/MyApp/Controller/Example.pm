package MyApp::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(msg => 'Welcome to the Mojolicious real-time web framework!');
}

sub channel {
  my $c = shift;
  my $i = 0;
  my $out = '';
  $c->inactivity_timeout(3600);

  # Forward messages from the browser to PostgreSQL
  $c->on(message => sub { 
	$i++;
        if ((($i % 3) == 0)&&(($i % 5) == 0)) {
                     $out = 'Z';
                } elsif (($i%3) == 0) {
                     $out = 'F';
                } elsif (($i%5)==0) {
                     $out = 'B';
                } else {
                     $out = $i;
        };
	shift->pg->pubsub->notify(mojochat => $out);
  });

  # Forward messages from PostgreSQL to the browser
  my $cb = $c->pg->pubsub->listen(mojochat => sub { $c->send(pop) });
  $c->on(finish => sub { 
  	shift->pg->pubsub->unlisten(mojochat => $cb);
  });
}

1;
