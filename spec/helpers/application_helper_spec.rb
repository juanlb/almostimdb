# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe '#class_active' do
    let(:controller_name) { 'users' }
    it 'create the active class' do
      controller.params[:controller] = 'users'
      expect(helper.class_active(controller_name)).to eq('active')
    end
  end

  describe '#bootstrap_class_for' do
    subject{helper.bootstrap_class_for(flash_type)}
    
    context 'success' do
      let(:flash_type) { 'success' }
      it 'return a success class' do
        expect(subject).to eq('alert-success')
      end
    end
    
    context 'error' do
      let(:flash_type) { 'error' }
      it 'return a danger class' do
        expect(subject).to eq('alert-danger')
      end
    end
    
    context 'alert' do
      let(:flash_type) { 'alert' }
      it 'return a warning class' do
        expect(subject).to eq('alert-warning')
      end
    end
    
    context 'notice' do
      let(:flash_type) { 'notice' }
      it 'return a info class' do
        expect(subject).to eq('alert-info')
      end
    end
    
    context 'success' do
      let(:flash_type) { 'other' }
      it 'return a other alert' do
        expect(subject).to eq('other')
      end
    end
  end
end
