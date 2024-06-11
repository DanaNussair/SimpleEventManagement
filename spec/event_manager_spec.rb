require 'rspec'
require_relative '../event_manager'

RSpec.describe EventManager do
  let(:manager) { EventManager.new }

  it 'starts off with an empty set of handlers' do
    expect(manager.instance_variable_get(:@handlers).length).to eq(0)
  end

  it 'subscribes and broadcasts to a single handler' do
    handler = proc {}
    allow(handler).to receive(:call)
    manager.subscribe(&handler)
    manager.broadcast('hello')

    expect(handler).to have_received(:call).with('hello')
  end

  it 'subscribes and broadcasts to multiple handlers' do
    handler1 = proc {}
    handler2 = proc {}
    allow(handler1).to receive(:call)
    allow(handler2).to receive(:call)
    manager.subscribe(&handler1)
    manager.subscribe(&handler2)
    manager.broadcast('hello')

    expect(handler1).to have_received(:call).with('hello')
    expect(handler2).to have_received(:call).with('hello')
  end

  it 'cannot subscribe to the same handler more than once' do
    handler = proc {}
    manager.subscribe(&handler)
    manager.subscribe(&handler)

    expect(manager.instance_variable_get(:@handlers).length).to eq(1)
  end

  it 'unsubscribes a handler' do
    handler = proc {}
    allow(handler).to receive(:call)
    manager.subscribe(&handler)
    manager.unsubscribe(&handler)
    manager.broadcast('hello')

    expect(handler).not_to have_received(:call)
  end

  it 'does not unsubscribe a handler that was not subscribed' do
    handler = proc {}
    allow(handler).to receive(:call)
    manager.unsubscribe(&handler)
    manager.broadcast('hello')

    expect(handler).not_to have_received(:call)
  end

  it 'subscribes, unsubscribes, and subscribes again' do
    handler = proc {}
    allow(handler).to receive(:call)
    manager.subscribe(&handler)
    manager.unsubscribe(&handler)
    manager.subscribe(&handler)
    manager.broadcast('hello')

    expect(handler).to have_received(:call).with('hello')
    expect(manager.instance_variable_get(:@handlers).length).to eq(1)
  end

  it 'broadcasts with multiple arguments' do
    handler = proc {}
    allow(handler).to receive(:call)
    manager.subscribe(&handler)
    manager.broadcast('hello', 'world')

    expect(handler).to have_received(:call).with('hello', 'world')
  end
end
