package MyApp::Controller::Hhh;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(msg => 'Welcome to the Mojolicious real-time web framework!');
}

sub hhhr {
  my $c = shift;
  $c->inactivity_timeout(3600);

   # Forward messages from the browser to PostgreSQL
  $c->on(message => sub { shift->pg->pubsub->notify(mojochat => shift) });

  # Forward messages from PostgreSQL to the browser
  my $cb = $c->pg->pubsub->listen(mojochat => sub { $c->send(pop) });
  $c->on(finish => sub { shift->pg->pubsub->unlisten(mojochat => $cb) });
}

sub hhhs {
  my $c = shift;
  $c->inactivity_timeout(3600);

   # Forward messages from the browser to PostgreSQL
  $c->on(message => sub { shift->pg->pubsub->notify(mojochat => shift) });

  # Forward messages from PostgreSQL to the browser
  my $cb = $c->pg->pubsub->listen(mojochat => sub { $c->send(pop) });
  $c->on(finish => sub { shift->pg->pubsub->unlisten(mojochat => $cb) });
}


1;
